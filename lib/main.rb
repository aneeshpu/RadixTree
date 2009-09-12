# To change this template, choose Tools | Templates
# and open the template in the editor.


def find(lang)
  ["java", "C#", "Ruby", "Erlang", "Haskell"].each_with_index { |language,index|  if language == lang;return index;end  }
  puts "Couldn't find #{lang}"
  ''
end

def find_with_lambda(lang)
  find_index=lambda {|language,index|
    if language != lang
      puts "#{lang} is not at #{index}"
      return 
    end

    #do some weird stuff with the lang
    puts "Yooo hoo I found the #{lang}"
  }
  
  ["java", "C#", "Ruby", "Erlang", "Haskell"].each_with_index { |language,index| find_index.call(language,index) }
  puts "Couldn't find #{lang}"
end

#puts find("Ruby")
#puts find "Erlang"
#puts find "java"
#puts find "C"

puts "--"
puts find_with_lambda "Ruby"


puts "nil"w.nil?