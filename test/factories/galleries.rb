


FactoryGirl.define do
  
  
  factory :gallery, :class => Gallery do
    name 'g name'
    galleryname 'g_name'
    is_feature false
    is_public true
    is_trash false
  end

  factory :pi_gallery, :class => Gallery do
    name 'g name'
    galleryname 'g_name'
    is_feature false
    is_public true
    is_trash false

    after(:create) do |r|
      r.tag = Tag.where( :name_seo => 'simple' ).first
      r.user = User.where( :username => 'simple' ).first
      r.save
    end
    
  end
  
  factory :g1, :class => Gallery do
    name 'g name'
    galleryname 'g_name'
    is_feature false
    is_public true
    is_trash false
  end
  
  factory :g2, :class => Gallery do
    name 'g name1'
    galleryname 'g_name2'
    is_feature false
    is_public true
    is_trash false
  end
  
  factory :g3, :class => Gallery do
    name 'blah blah 2'
    user User.all[0]
    galleryname 'a2'
    descr 'blah blah'
    is_feature false
    is_public true
    is_trash false
  end
  
end