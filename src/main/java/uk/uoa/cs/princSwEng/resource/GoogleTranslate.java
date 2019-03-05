package uk.uoa.cs.princSwEng.resource;


import com.google.api.translate.Language;
import com.google.api.translate.Translate;*/
import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.translate.Detection;
import com.google.cloud.translate.Language;
import com.google.cloud.translate.Translate;
import com.google.cloud.translate.TranslateOptions;
import com.google.cloud.translate.Translation;
import java.util.*;



public class GoogleTranslate {
    private static final String TAG = GoogleTranslate.class.getSimpleName();
    private static final String API_KEY = "AIzaSyAkjqDtrIaZ96s4cQTHVR-SkHZIhehL3Gc";

    private GoogleTranslate() {
        // Private constructor to enforce noninstantiability
    }

     /**
   * Translates text from a given Language to another given Language using Google Translate.
   * 
   * @param text The String to translate.
   * @param from The language code to translate from.
   * @param to The language code to translate to.
   * @return The translated String.
   * @throws Exception on error.
   */

   public static String execute(final String text, final Language from, final Language to) throws
     Exception {
       Translate translate = TranslateOptions.getDefaultInstance().getService();
       Translation translation = translate.translate(
		text, 
		TranslateOption.sourceLanguage("from"); 
		TranslateOption.targetLanguage("to"); 

	return(translation.getTranslatedText());
     } 
   } 
       
}