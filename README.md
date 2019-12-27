# godot-maximilien-adventure

A mario like game created for my 4 years old (at this time) nephew Maximillien.



## Code guideline

- Use double quote instead of simple quote

- Casting should be using for non evident data. 

  ```python
  var string_value := "foobar"
  var unset_value: Ressoure = null 
  ```

* Every node variable should be capitalize

  ```python
  onready var Physics2D: Node2D = $Physics2Dpy
  ```

* Internal function that is connected to signal will alway be prefixed with `_on` and followed by a maj

  ```c
  func _on_Player_entered(body: Player):
  ```



### Documentation

Betside the classic `@param` `@return` tag, I added `@emit`, to reference emitted signal inside the function, and `@signal` to reference by witch signal the function can be triggered.



## Credits

### Sprites

[Open Pixel Art project](http://www.openpixelproject.com/) 

[Sunny Land 2D Pixel Art Pack](https://ansimuz.itch.io/sunny-land-pixel-game-art)

[Pixel health bar asset pack](https://adwitr.itch.io/pixel-health-bar-asset-pack) 

[keyboard-controller-keys]( https://hyohnoo.itch.io/keyboard-controller-keys)

[free-pixel-gamepad-buttons](https://eggboycolor.itch.io/free-pixel-gamepad-buttons)



### Fonts

[pixelmix font](https://www.dafont.com/fr/pixelmix.font)

[Arcade Classic Font](https://www.1001fonts.com/arcadeclassic-font.html#more) 

[Joystick monospace](https://www.dafont.com/joystix.font)

[SFPixelate](https://www.dafont.com/joystix.font?text=SFPixelate)

[Minecraftia-Regular](https://www.dafont.com/joystix.font?text=Minecraftia-Regular)



### Sounds and musics 	

[The Essential Retro Video Game Sound Effects Collection [512 sounds] By Juhani Junkala](https://opengameart.org/content/512-sound-effects-8-bit-style) 

https://freesound.org/people/a_guy_1/sounds/447566/

*Obviously if an asset is not credited, contact me, I always try to credits the asset I use, but something I can just forget to do it.*

