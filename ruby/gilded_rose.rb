class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      apple(item)
      decrease_sell_in_value_when_not_sulfuras(item)
      cherry(item)
    end
  end

  def cherry(item)
    if item.sell_in < 0
      kiwi(item)
    end
  end

  def decrease_sell_in_value_when_not_sulfuras(item)
    if is_item_not_sulfuras(item)
      item.sell_in = item.sell_in - 1
    end
  end

  def apple(item)
    if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
      grape(item)
    else
      increase_quality_when_below_fifty(item)
    end
  end

  private

  def kiwi(item)
    if item.name != "Aged Brie"
      mango(item)
    else
      increase_quality_when_quality_is_below_fifty(item)
    end
  end

  def mango(item)
    if item.name != "Backstage passes to a TAFKAL80ETC concert"
      grape(item)
    else
      item.quality = item.quality - item.quality
    end
  end

  def increase_quality_when_below_fifty(item)
    if item.quality < 50
      increase_quality_by_one(item)
      increase_quality_for_backstage_passes_when_appropriate(item)
    end
  end

  def increase_quality_for_backstage_passes_when_appropriate(item)
    if item.name == "Backstage passes to a TAFKAL80ETC concert"
      increase_quality_when_sell_in_below_eleven_and_quality_below_fifty(item)
      increase_quality_when_sell_in_is_below_six_and_quality_below_fifty(item)
    end
  end

  def increase_quality_when_sell_in_is_below_six_and_quality_below_fifty(item)
    if item.sell_in < 6
      increase_quality_when_quality_is_below_fifty(item)
    end
  end

  def increase_quality_when_sell_in_below_eleven_and_quality_below_fifty(item)
    if item.sell_in < 11
      increase_quality_when_quality_is_below_fifty(item)
    end
  end

  def increase_quality_when_quality_is_below_fifty(item)
    if item.quality < 50
      increase_quality_by_one(item)
    end
  end

  def increase_quality_by_one(item)
    item.quality = item.quality + 1
  end

  def grape(item)
    if item.quality > 0
      blackberry(item)
    end
  end

  def blackberry(item)
    if is_item_not_sulfuras(item)
      item.quality = item.quality - 1
    end
  end

  def is_item_not_sulfuras(item)
    item.name != "Sulfuras, Hand of Ragnaros"
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality

  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
