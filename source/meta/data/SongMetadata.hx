// partially and accidentally based on the weekly metadata https://github.com/OrbyyOrbinaut/FNF-Weekly-Public/blob/main/source/meta/data/Metadata.hx

package meta.data;

import sys.io.File;
import sys.FileSystem;
import haxe.Json;

typedef SongMetadata = {
    var card:SongCardData;
    var credits:SongCredits;
}

typedef SongCardData = {
    var name:String;
    var expandBeat:Int;
    var duration:Int;
    var font:Null<String>;
}

typedef SongCredits = {
    var music:Null<Array<String>>;
    var art:Null<Array<String>>;
    var coding:Null<Array<String>>;
    var chart:Null<Array<String>>;
    var va:Null<Array<String>>;
};

class Metadata {
    public static function load(song:String):SongMetadata {
        try {
            var rawJson = null;
            
            var formattedSong:String = Paths.formatToSongPath(song);
            var path:String = formattedSong + '/metadata';
            #if MODS_ALLOWED
            var moddyFile:String = Paths.modsJson(path);
            
            if(FileSystem.exists(moddyFile)) {
                rawJson = File.getContent(moddyFile).trim();
            }
            #end

            if(rawJson == null) {
                #if sys
                rawJson = File.getContent(Paths.json(path)).trim();
                #else
                rawJson = Assets.getText(Paths.json(path)).trim();
                #end	
            }

            while (!rawJson.endsWith("}"))
            {
                rawJson = rawJson.substr(0, rawJson.length - 1);
                // LOL GOING THROUGH THE BULLSHIT TO CLEAN IDK WHATS STRANGE
            }

            var f =cast Json.parse(rawJson);

            trace('Loaded metadata!');
            trace(f);

            return f;
        }
        catch(e) {
            trace(e);
            return null;
        }
    }
}