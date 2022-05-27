require 'sighting_entity'

RSpec.describe SightingEntity do
  it "constructs correctly" do
    sighting = SightingEntity.new("I saw Brian")
    expect(sighting.contents).to eq "I saw Brian"
    expect(sighting.time.is_a? Time).to eq true
    expect(sighting.id).to eq nil
  end
end
