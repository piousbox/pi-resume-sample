


FactoryGirl.define do
  
  
  factory :gallery, :class => Gallery do
    name 'g name'
    galleryname 'g_name'
    is_feature '0'
    
  end
  
  factory :g1, :class => Gallery do
    name 'g name'
    galleryname 'g_name'
    is_feature '0'
    
  end
  
  factory :g2, :class => Gallery do
    name 'g name1'
    galleryname 'g_name2'
    is_feature '0'
    
  end
  
end