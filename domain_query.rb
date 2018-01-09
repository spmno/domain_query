require 'open-uri'
require 'json'

class DomainQuery
  @@uri_prefix = 'https://www.threatcrowd.org/searchApi/v2/domain/report/?domain='
  @@uri_suffix_array = %w[cn com me cc fun wang vip club top red ren mon link so tv wiki]

  def query
    file = File.open('pinyin.txt', 'r')
    file.each_line do |line|
      puts line
      query_domain(line)
    end
    file.close
  end

  def write_to_file(info)
    write_file = File.open('./result.txt', 'a')
    write_file.write(info)
    write_file.write("\n");
    write_file.flush
    write_file.close
  end

  def query_domain(name)
    @@uri_suffix_array.each do |suffix|
      uri = @@uri_prefix + name.chomp + '.' + suffix
      puts uri
      begin
        html_response = nil
        open(uri) do |http|
          html_response = http.read
        end
        respond_obj = JSON.parse(html_response)
        if (respond_obj["response_code"] == '0')
          puts 'hahahaha - hahahaha'
          write_to_file(uri)
        end
      rescue
          puts 'error'
          write_to_file(uri)
      end
    end
  end
end


domain_queryer = DomainQuery.new
domain_queryer.query

