class TagsController < ApplicationController
  
 private

 def tag_list
   params.require(:tag).permit(:name)
 end

end
