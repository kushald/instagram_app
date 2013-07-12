task :add_categories  => :environment do
  arr = ["General", "Celebrities", "Photographers", "Musicians", "Models", "Artists"]
  arr.each_with_index do |a,i|
    p a.inspect
    image = InterestingUser.where("category_type = ?", i+1).collect(&:instagram_profile_picture).sample
    Category.create!(:name => a, :image => image)
  end
end