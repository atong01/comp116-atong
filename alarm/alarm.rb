#!/bin/ruby
require 'packetfu'
require 'base64'

def log()
    incidents = 0
    File.open(ARGV.last, "r") do |f|
        while (line = f.gets)
            log_form = /^(\S+) - \S+ \[(\S+ \+\d{4})\] "([^"]*)" (\d{3}) (\d+|-) "(.*?)" "([^"]+)"$/
            data = line.scan(log_form).flatten
            if data[6].match(/NMap/)
                incidents = incidents + 1 
                alert = [incidents, "NMap Attack", data[0], "HTTP", data[2]]
                puts "%d. ALERT: %s is detected from %s (%s) (%s)!" %alert
            end
            if (data[3][0] == "4" && data[2].match(/HTTP/))
                incidents = incidents + 1 
                alert = [incidents, "HTTP error", data[0], "HTTP", data[2]]
                puts "%d. ALERT: %s is detected from %s (%s) (%s)!" %alert
            end                
            if data[2].match(/\\x/)
                incidents = incidents + 1 
                alert = [incidents, "Shellcode Attack", data[0], "HTTP", data[2]]
                puts "%d. ALERT: %s is detected from %s (%s) (%s)!" %alert
            end
        end
    end
end

def live()
    #mask for tcp header flags for xmas scan
    xmas_mask = (1<<5) + (1<<3) + 1
    incidents = 0
    cap = PacketFu::Capture.new(:start => true, :iface=> 'eth0', :promisc => true)
    cap.stream.each do |p|
        pkt = PacketFu::Packet.parse(p)
        if  pkt.is_ip?
            packet_info = [pkt.ip_saddr, pkt.ip_daddr, pkt.size, pkt.proto.last]
            if pkt.proto.last == "TCP"
                pkt_flags = pkt.tcp_header.tcp_flags.to_i

                if (pkt_flags == 0 || pkt_flags == xmas_mask)
                    incidents = incidents + 1
                    scan_type = pkt_flags == 0 ? "NULL scan" : "Xmas scan"
                    alert_info = [incidents, scan_type, pkt.ip_saddr, pkt.proto.last,
                                  Base64.encode64(pkt.to_s)]
                    puts "%d. ALERT: %s is detected from %-15s (%s) (%s)!" %alert_info
                end
            elsif pkt.proto.last == "HTTP"
                data = pkt.to_s
                if (data.match(/[45]\d{3}(\s|-)?\d{4}(\s|-)?\d{4}(\s-)?\d{4}/) ||
                    data.match(/6011(\s|-)?\d{4}(\s|-)?\d{4}(\s-)?\d{4}/)      ||
                    data.match(/3\d{3}(s|-)?d{6}(s|-)?d{5}/))
                    incidents = incidents + 1
                    alert_info = [incidents, "Credit card leaked in the clear",
                                  pkt.ip_saddr, pkt.proto.last]
                    puts "%d. ALERT: %s from %-15s (%s) (%s)!" %alert_info
                end
            end
        end
    end
end

if (ARGV.length == 2 && ARGV[0] == "-r")
    log
else
    live
end

