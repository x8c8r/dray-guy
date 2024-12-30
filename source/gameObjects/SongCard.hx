package gameObjects;

import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import meta.data.SongMetadata;

class SongCard extends FlxTypedSpriteGroup<FlxSprite>{

    var meta:SongMetadata;
    var tex:String = "";
    var font:String = "vcr.ttf";

    var text:FlxText;

    public function new(x:Int, y:Int, meta:SongMetadata) {
        super(x, y);

        this.meta = meta;
        tex = '"${meta.card.name}"\nSong: ${meta.credits.music.join(', ')}';
        if (meta.card.font != null) font = meta.card.font;

        text = new FlxText(x + 5, y + 5, 0, tex);
        text.setFormat(Paths.font(font), 36, FlxColor.WHITE);

        var textbg:FlxSprite = new FlxSprite(x,y).makeGraphic(Std.int(text.width + 10), Std.int(text.height + 10), FlxColor.fromString("#121212"));
        
        add(textbg);
        add(text);
    }

    public function show() {
        var init = this.x;
        FlxTween.tween(this, {x: init + width}, 0.5, {ease: FlxEase.expoIn, onComplete: twn -> {
            FlxTween.tween(this, {x: init}, 0.5, {ease: FlxEase.expoOut, startDelay: meta.card.duration});
        }});
    }
}