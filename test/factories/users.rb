
FactoryGirl.define do
  
  
  factory :user do
    
    email 'user@user.com'
    username 'simple'
    group_id 1
    
    password 's3cret'
    encrypted_password '$2a$10$PoBe1MvkoGJsjMVTEjKqgeBUp.xdfzWoiDjBzQhtLAj16NqIa2fOy'
    
  end
  
  factory :piousbox, :class => User do
    email 'piousbox@gmail.com'
    username 'piousbox'
    group_id 1
    password 's3cret'
    encrypted_password '$2a$10$PoBe1MvkoGJsjMVTEjKqgeBUp.xdfzWoiDjBzQhtLAj16NqIa2fOy'
    
  end
  
end