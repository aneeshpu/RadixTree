# To change this template, choose Tools | Templates
# and open the template in the editor.

class String
  def initialize
      
  end

  def starts_with other
    index(other) == 0
  end

  def common_beginning other
    common_start = ""
    lam = lambda do |cstr|
      common_start << cstr if other.starts_with(common_start+cstr)
    end

    (0..length).to_a.each{|index| lam.call slice index..index}

    common_start
  end
end
