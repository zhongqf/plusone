When /^I click "(.*?)" of organization "(.*?)"$/ do |object, org|
  all("ul li").each do |li|
    if li.text =~ /#{org.to_s}/
      li.find(:xpath,".//*[.='#{object}']").click
    end
  end

end