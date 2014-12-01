#test

begin
File.open("./public/profile_image_2_thumb.png").read
rescue
File.open("./public/profile_image_-1_thumb.png").read
end
