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

* [Open Pixel Art project](http://www.openpixelproject.com/) 

* [Sunny Land 2D Pixel Art Pack](https://ansimuz.itch.io/sunny-land-pixel-game-art)

* [Pixel health bar asset pack](https://adwitr.itch.io/pixel-health-bar-asset-pack) 

* [keyboard-controller-keys]( https://hyohnoo.itch.io/keyboard-controller-keys)

* [free-pixel-gamepad-buttons](https://eggboycolor.itch.io/free-pixel-gamepad-buttons)

* [Pixel Parchment UI Kit](https://sasquatchii.itch.io/pixel-parchment-ui-kit)

### Fonts

* [pixelmix font](https://www.dafont.com/fr/pixelmix.font)

* [Arcade Classic Font](https://www.1001fonts.com/arcadeclassic-font.html#more) 

* [Joystick monospace](https://www.dafont.com/joystix.font)

* [SFPixelate](https://www.dafont.com/joystix.font?text=SFPixelate)

* [Minecraftia-Regular](https://www.dafont.com/joystix.font?text=Minecraftia-Regular)

* [sh-pinscher](https://www.fontsquirrel.com/fonts/sh-pinscher)

* [lady radical](https://www.dafont.com/lady-radical.font)

### Sounds

* [The Essential Retro Video Game Sound Effects Collection [512 sounds] By Juhani Junkala](https://opengameart.org/content/512-sound-effects-8-bit-style) 

* [robot gibberish.wav](https://freesound.org/people/a_guy_1/sounds/447566)

### Musics

* [Solve the puzzle](https://patrickdearteaga.com) by Patrick de Arteaga
* [Su Turno](https://patrickdearteaga.com) by Patrick de Arteaga
* [Ruined](https://patrickdearteaga.com) Planet by Patrick de Arteaga
* [Intrusión](https://patrickdearteaga.com) by Patrick de Arteaga
* [Great Little Challenge](https://patrickdearteaga.com) by Patrick de Arteaga
* [Friends](https://patrickdearteaga.com) by Patrick de Arteaga
* [Chiptronical](https://patrickdearteaga.com) by Patrick de Arteaga
* [Lyonesse by Patrick de Arteaga](https://patrickdearteaga.com)
* [I miss you](https://patrickdearteaga.com) by Patrick de Arteaga
* [Game over](https://patrickdearteaga.com) by Patrick de Arteaga
* [Mall](https://patrickdearteaga.com) by Patrick de Arteaga
* [Boss fight](https://patrickdearteaga.com) by Patrick de Arteaga
* [Estimable](https://patrickdearteaga.com) by Patrick de Arteaga
* [Las Dos Fronteras](https://patrickdearteaga.com) by Patrick de Arteaga
* [The Three Princesses of Lilac Meadow](https://patrickdearteaga.com) by Patrick de Arteaga
* [Yellow Forest](https://patrickdearteaga.com) by Patrick de Arteaga



*Obviously if an asset is not credited, contact me, I always try to credits the asset I use, but something I can just forget to do it.*

