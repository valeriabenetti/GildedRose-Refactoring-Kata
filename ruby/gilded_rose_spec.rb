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

    it "changes sell in value" do
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

    it "checks quality of an item is never more than 50" do
      #arrange
      initial_quality = 50
      expected_quality = initial_quality
      items = [Item.new("Aged Brie", 1, initial_quality)]

      #act
      GildedRose.new(items).update_quality()

      #assert
      expect(items[0].quality).to eq expected_quality
    end

    it "checks that Sulfuras quality is always 80" do
      #arrange
      initial_quality = 80
      expected_quality = initial_quality
      items = [Item.new("Sulfuras, Hand of Ragnaros", 1, initial_quality)]

      #act
      GildedRose.new(items).update_quality()

      #assert
      expect(items[0].quality).to eq expected_quality
    end

    context "checks that Backstage Passes" do

      it "increases in quality as its sell_in value is > 10" do
        #arrange
        initial_quality = 20
        initial_sell_in = 12
        expected_quality = initial_quality + 1
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", initial_sell_in, initial_quality)]

        #act
        GildedRose.new(items).update_quality()

        #assert
        expect(items[0].quality).to eq expected_quality
      end

      it "increases in quality by 2 as its sell_in value is <= 10" do
        #arrange
        initial_quality = 20
        initial_sell_in = 10
        expected_quality = initial_quality + 2
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", initial_sell_in, initial_quality)]

        #act
        GildedRose.new(items).update_quality()

        #assert
        expect(items[0].quality).to eq expected_quality
      end

      it "increases in quality by 3 as its sell_in value is <= 5" do
        #arrange
        initial_quality = 20
        initial_sell_in = 5
        expected_quality = initial_quality + 3
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", initial_sell_in, initial_quality)]

        #act
        GildedRose.new(items).update_quality()

        #assert
        expect(items[0].quality).to eq expected_quality
      end

      it "quality drops to 0 after the sell_in date" do
        #arrange
        initial_quality = 1000
        initial_sell_in = 0
        expected_quality = 0
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", initial_sell_in, initial_quality)]

        #act
        GildedRose.new(items).update_quality()

        #assert
        expect(items[0].quality).to eq expected_quality
      end

    end

    it "check conjured items quality degrades twice as fast" do
      #arrange
      initial_quality = 20
      initial_sell_in = 10
      expected_quality = initial_quality - 2
      items = [Item.new("", initial_sell_in, initial_quality)]

      # act

      # assert

    end
    # TODO: Finish Conjured Spec Test
    #       Refactor Gilded Rose File
    #       Code Snippets
    #       Describe it block naming conventions
    #       Keyboard shortcuts for expanding and collapsing code blocks
  end

end
