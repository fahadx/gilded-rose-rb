class GildedRose
  def initialize(items)
    @items = items
  end


  def change_quality_by(item,value)
    new_value = item.quality+value


    #can't be negative
    if(new_value < 0)
      new_value = 0
    end

    #can't be greater then 50
    if(new_value > 50)
     new_value = 50
    end

    item.quality=new_value
    


  end


  def update_quality()
    @items.each do |item|
      
      if item.name == 'Aged Brie'
        # 'Aged Brie' actually increases in Quality the older it gets
        change_quality_by(item,1)

      elsif item.name.downcase.include? 'backstage passes'
        # 'Backstage passes', like aged brie, increases in Quality as its SellIn value approaches; Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but Quality drops to 0 after the concert

        if item.sell_in <= 0
          #set quality to zero
          change_quality_by(item, -1*item.quality)
        elsif item.sell_in <= 5
          #increase by 3
          change_quality_by(item,3)
        elsif item.sell_in <= 10
          #increase by 2
          change_quality_by(item,2)
        else
          #increase by 1
          change_quality_by(item,1)
        end

      elsif item.name.downcase.include? 'sulfuras'
        # 'Sulfuras', being a legendary item, never has to be sold or decreases in Quality
        # no change in quality
        # no decrease in sell_in

        item.sell_in += 1 # to cancel the decrease effect for Sulfuras
      
      elsif item.name.downcase.include? 'conjured'
        # 'Conjured' items degrade in Quality twice as fast as normal items
        
        change_quality_by(item,-2)

      else
        # for other items decreate quality by 1
        
        change_quality_by(item,-1)
      
      end
      
      #decreate the sell in value for all
      item.sell_in = item.sell_in - 1

    end  
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
