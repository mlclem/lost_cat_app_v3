require 'cat_entity'

RSpec.describe CatEntity do
  it "constructs correctly " do
    new_cat = CatEntity.new(
      "nyan cat", 
      "02011 404 606",
      "A colourful cat, last seen flying through space",
      "gogonyancatgo"
    )
    expect(new_cat.name).to eq "nyan cat"
    expect(new_cat.phone).to eq "02011 404 606"
    expect(new_cat.description).to eq "A colourful cat, last seen flying through space"
    expect(new_cat.password).to eq "gogonyancatgo"
    expect(new_cat.id).to eq nil
  end
end
