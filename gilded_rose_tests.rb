require File.join(File.dirname(__FILE__), 'gilded_rose')
require 'test/unit'

class TestUntitled < Test::Unit::TestCase
  

  def test_quality_should_not_be_greater_then_50
  	items = [
  				Item.new('Aged Brie', 2, 49),
  				Item.new('Backstage passes',2,49),
  				Item.new('Backstage passes',7,49),
  				Item.new('Backstage passes',12,50),
  				Item.new('Conjured Mana Cake',3,49)
  			]
    GildedRose.new(items).update_quality()
    assert items[0].quality <= 50
    assert items[1].quality <= 50
    assert items[2].quality <= 50
    assert items[3].quality <= 50
    assert items[4].quality <= 50

  end

  def test_quality_should_not_be_in_negative
    items = [
          Item.new('Elixir of the Mongoose', 2, 0),
        ]
    GildedRose.new(items).update_quality()
    assert items[0].quality >= 0
  	
  end

  def test_aged_brie_quality_should_increment_by_one
    items = [
          Item.new('Aged Brie', 2, 0),
        ]
    GildedRose.new(items).update_quality()
    assert items[0].quality == 1
  end

  def test_backstage_passes_quality_should_increment_by_1_if_sell_in_gt_10
    items = [
          Item.new('Backstage passes to a TAFKAL80ETC concert', 12, 1),
        ]
    GildedRose.new(items).update_quality()
    assert items[0].quality == 2
  end 

  def test_backstage_passes_quality_should_be_zero_if_sell_in_0_or_less
    items = [
          Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 12),
        ]
    GildedRose.new(items).update_quality()
    assert items[0].quality == 0
  end

  def test_backstage_passes_quality_should_increment_by_3_if_sell_in_lt_eq_5
    items = [
          Item.new('Backstage passes to a TAFKAL80ETC concert', 3, 12),
        ]
    GildedRose.new(items).update_quality()
    assert items[0].quality == 15
  end

  def test_backstage_passes_quality_should_increment_by_2_if_sell_in_lt_eq_10_and_gt_5
    items = [
          Item.new('Backstage passes to a TAFKAL80ETC concert', 7, 12),
        ]
    GildedRose.new(items).update_quality()
    assert items[0].quality == 14
  end

  def test_sulfuras_quality_should_not_decrease
    items = [
          Item.new('Sulfuras, Hand of Ragnaros', 7, 12),
        ]
    GildedRose.new(items).update_quality()
    assert items[0].quality == 12
  end

  def test_sulfuras_sell_in_should_not_decrease
    items = [
          Item.new('Sulfuras, Hand of Ragnaros', 7, 12),
        ]
    GildedRose.new(items).update_quality()
    assert items[0].sell_in == 7
  end

  def test_other_items_should_decrease_sell_in_by_1
      items = [
          Item.new('Any Other Item', 7, 12),
        ]
    GildedRose.new(items).update_quality()
    assert items[0].quality == 11
end

  def test_other_items_should_decrease_quality_by_1
      items = [
          Item.new('Any Other Item', 7, 12),
        ]
    GildedRose.new(items).update_quality()
    assert items[0].sell_in == 6
  end

  def test_conjured_quality_should_increment_by_2
    items = [
          Item.new('Conjured Mana Cake', 7, 12),
        ]
    GildedRose.new(items).update_quality()
    assert items[0].quality == 10
  end


end
