require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      #arrange
      initial_name = "foo"
      expected_name = initial_name
      items = [Item.new(initial_name, 0, 0)]

      #act
      GildedRose.new(items).update_quality()

      #assert
      expect(items[0].name).to eq expected_name
    end

    it "change sell in value" do
      #arrange
      sell_in_init = 4
      expected_result = sell_in_init - 1
      items = [Item.new("foo", sell_in_init, 42)]

      #act
      GildedRose.new(items).update_quality()

      #assert
      expect(items[0].sell_in).to eq expected_result
    end

    it "changes quality value" do
      #arrange
      initial_quality = 42
      degradation_rate = 1
      expected_quality = initial_quality - degradation_rate
      items = [Item.new("foo", 4, initial_quality)]

      #act
      GildedRose.new(items).update_quality()

      #assert
      expect(items[0].quality).to eq expected_quality
    end

    it "degrades 2 times faster when sell by date has passed" do
      #arrange
      initial_quality = 42
      degradation_rate = 2
      expected_quality = initial_quality - degradation_rate
      items = [Item.new("Boring Item", 0, initial_quality)]

      #act
      GildedRose.new(items).update_quality()

      #assert
      expect(items[0].quality).to eq expected_quality
    end

    it "checks quality of item is never negative" do
      #arrange
      initial_quality = 0
      expected_quality = initial_quality
      items = [Item.new("Boring Item", 0, initial_quality)]

      #act
      GildedRose.new(items).update_quality()

      #assert
      expect(items[0].quality).to eq expected_quality
    end

    it "verify that Aged Brie's quality increases by one the older it gets" do
      #arrange
      items = [Item.new("Aged Brie", 1, 12)]

      #act
      GildedRose.new(items).update_quality()

      #assert
      expect(items[0].quality).to eq 13
      expect(items[0].sell_in).to eq 0
    end

    it "quality of an item is never more than 50" do
      #arrange
      initial_quality = 50
      expected_quality = initial_quality
      items = [Item.new("Aged Brie", 1, initial_quality)]

      #act
      GildedRose.new(items).update_quality()

      #assert
      expect(items[0].quality).to eq expected_quality
    end

    # TODO: Sulfuras
    #       Code Snippets
    #       Describe it block naming conventions
    #       Keyboard shortcuts for expanding and collapsing code blocks
  end

end

# - All items have a SellIn value which denotes the number of days we have to sell the item
# - All items have a Quality value which denotes how valuable the item is
# - At the end of each day our system lowers both values for every item
#
# Pretty simple, right? Well this is where it gets interesting:
#
# - Once the sell by date has passed, Quality degrades twice as fast
# - The Quality of an item is never negative
# - "Aged Brie" actually increases in Quality the older it gets
# - The Quality of an item is never more than 50
# - "Sulfuras", being a legendary item, never has to be sold or decreases in Quality
#
# - "Backstage passes", like aged brie, increases in Quality as its SellIn value approaches;
# Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but
# Quality drops to 0 after the concert
#
# We have recently signed a supplier of conjured items. This requires an update to our system:
#
# - "Conjured" items degrade in Quality twice as fast as normal items
#
# Feel free to make any changes to the UpdateQuality method and add any new code as long as everything
# still works correctly. However, do not alter the Item class or Items property as those belong to the
# goblin in the corner who will insta-rage and one-shot you as he doesn't believe in shared code
# ownership (you can make the UpdateQuality method and Items property static if you like, we'll cover
# for you).
#
# Just for clarification, an item can never have its Quality increase above 50, however "Sulfuras" is a
# legendary item and as such its Quality is 80 and it never alters.