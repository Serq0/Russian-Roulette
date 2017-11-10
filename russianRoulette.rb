def wait(time)
  sleep(time)
end

class Ending
  def initialize()
    endingtitle = "initialize"
    random = rand(1 .. 5)
    case random
      when 1 then endingtitle = "Po nagrode zglos sie do przewodniczacego kola."
      when 2 then endingtitle = "Wygrales paszport polsatu."
      when 3 then endingtitle = "W nagrode na tablicy narysuj kota."
      when 4 then endingtitle = "W nagrode opowiedz zart."
      when 5 then endingtitle = "Masz szczescie!"
    end
    puts endingtitle
  end
end

class Player
  def initialize()
    alive = 1
    position = 0
  end
  
  #position = 0
  #alive = 1
  def alive()
    @alive
  end
  def alive=(a)
    @alive = a
  end
  def position()
    return @position
  end
  def selectPosition(min,max)
    puts "Wybierz pozycje od #{min} do #{max}"
    positionSelected = gets.to_i
    if positionSelected >= min and positionSelected <= max
      @position = positionSelected
      puts "Usiadles na krzesle nr #{position.to_i}, goodluck!"
    else
      selectPosition(min,max)
    end
  end
end

class Gun
  def initialize(min, max)
    puts "Polerowanie broni."
    wait(3)
    #bulletSlot(min, max)
  end
  def bulletSlot(min, max)
    test = rand(min .. max)
    return test
  end
end


class Game
  MAXPLAYERS = 6
  MINPLAYERS = 1
  #killedplayers = 0
  def killedplayers()
    @killedplayers
  end
  def MAXPLAYERS()
    @MAXPLAYERS
  end
  def MINPLAYERS()
    @MINPLAYERS
  end
  
  def selectPosition(min,max)
    @player.selectPosition(min,max)
  end
  
  def returnPlayerPosition()
    return @player.position
  end
  
  def bulletSlot(min,max)
    @gun.bulletSlot(min,max)
  end
  
  def eliminate(playersLeft,target,killedplayers,ppos)
    loop = 1
    emptyGun = 0
    if @player.alive == 1
      while emptyGun == 0 do
        puts "Lufa przystawiona do gracza z krzeslem o nr #{loop}"
        wait(loop)
        if loop == target
         puts "ZABITY!"
         #puts "Siedziales na nr #{ppos}"
         emptyGun = 1
         killedplayers = killedplayers.to_i + 1
         if target == ppos
           @player.alive = 0
           puts "Siedziales na tym krzesle. Twoje organy zostaly wystawione na aukcje..."
         end
         else
         puts "Bron nie wystrzelila!"
         wait(1)
        end
        loop = loop+1
      end
    end
  end
  
  def initialize()
    puts "Witaj w rosyjskiej ruletce."
    killedplayers = 0
    @player = Player.new()
    @player.alive = 1
    selectPosition(MINPLAYERS.to_i,MAXPLAYERS.to_i)
    @gun = Gun.new(MINPLAYERS.to_i,MAXPLAYERS.to_i)
    
    (MAXPLAYERS.to_i-1).times do
      eliminate(MAXPLAYERS.to_i - killedplayers.to_i, bulletSlot(MINPLAYERS, MAXPLAYERS.to_i - killedplayers.to_i).to_i,killedplayers.to_i, @player.position.to_i)
      killedplayers = killedplayers + 1 
      if @player.alive == 1
        if ((MAXPLAYERS - killedplayers.to_i) > 1)
          wait(1)
          puts "Zostalo #{MAXPLAYERS - killedplayers} zywych."
          selectPosition(MINPLAYERS.to_i,MAXPLAYERS.to_i - killedplayers.to_i)
        end
      end
    end
    
    if @player.alive == 1
      puts "Brawo! Przezyles do konca."
      ending = Ending.new()
    end
    
  end
  
  
end

game = Game.new()




