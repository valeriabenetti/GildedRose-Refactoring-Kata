class GildedRose
  MAX_QUALITY = 50
  CONCERT_IS_CLOSE = 11
  CONCERT_IS_IMMINENT = 6

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      checks_that_item_isnt_aged_brie_or_backstage_pass_and_change_quality(item)
      decrease_sell_in_value_when_not_sulfuras(item)
      change_quality_when_passed_sell_in_date(item)
    end
  end

  def change_quality_when_passed_sell_in_date(item)
    if sell_in_date_has_passed(item)
      increase_quality_of_aged_brie_or_decrease_for_other_item(item)
    end
  end

  def decrease_sell_in_value_when_not_sulfuras(item)
    if is_item_not_sulfuras(item)
      item.sell_in = item.sell_in - 1
    end
  end

  def checks_that_item_isnt_aged_brie_or_backstage_pass_and_change_quality(item)
    if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
      decrease_quality_when_appropriate(item)
    else
      increase_quality_when_below_max(item)
    end
  end

  private

  def sell_in_date_has_passed(item)
    item.sell_in < 0
  end

  def increase_quality_of_aged_brie_or_decrease_for_other_item(item)
    if item.name != "Aged Brie"
      checks_that_item_isnt_backstage_passes_and_decrements_appropriately(item)
    else
      increase_quality_when_below_max_quality(item)
    end
  end

  def checks_that_item_isnt_backstage_passes_and_decrements_appropriately(item)
    if item.name != "Backstage passes to a TAFKAL80ETC concert"
      decrease_quality_when_appropriate(item)
    else
      item.quality = item.quality - item.quality
    end
  end

  def increase_quality_when_below_max(item)
    if item.quality < MAX_QUALITY
      increase_quality(item)
      increase_quality_for_backstage_passes_as_concert_date_approaches(item)
    end
  end

  def increase_quality_for_backstage_passes_as_concert_date_approaches(item)
    if item.name == "Backstage passes to a TAFKAL80ETC concert"
      increase_quality_when_concert_is_close_and_below_max_quality(item)
      increase_quality_when_concert_is_imminent_and_below_max_quality(item)
    end
  end


  def increase_quality_when_concert_is_imminent_and_below_max_quality(item)
    if item.sell_in < CONCERT_IS_IMMINENT
      increase_quality_when_below_max_quality(item)
    end
  end


  def increase_quality_when_concert_is_close_and_below_max_quality(item)
    if item.sell_in < CONCERT_IS_CLOSE
      increase_quality_when_below_max_quality(item)
    end
  end

  def increase_quality_when_below_max_quality(item)
    if item.quality < MAX_QUALITY
      increase_quality(item)
    end
  end

  def increase_quality(item)
    item.quality = item.quality + 1
  end

  def decrease_quality_when_appropriate(item)
    if item.quality > 0
      decrease_quality_when_not_sulfuras(item)
    end
  end

  def decrease_quality_when_not_sulfuras(item)
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
