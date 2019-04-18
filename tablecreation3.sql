-- Database: postgres
-- DROP DATABASE postgres;

DROP TABLE IF EXISTS Sentences cascade;
CREATE TABLE Sentences (id SERIAL, internal_id VARCHAR(35), sentence VARCHAR(1000), PRIMARY KEY(id));
COPY Sentences(internal_id, sentence) FROM 'C:\Users\Nucci\Documents\MetaTranslator\src\main\database\corpora\VUA1\AwkParsingFinalResult.txt' DELIMITER '|' ENCODING 'latin1';
COPY Sentences(internal_id, sentence) FROM 'C:\Users\Nucci\Documents\Metatranslator\src\main\database\corpora\MOH1\MOHAWK.txt'  DELIMITER '|' ENCODING 'UTF-8';
COPY Sentences(internal_id, sentence) FROM 'C:\Users\Nucci\Documents\Metatranslator\src\main\database\corpora\FLA1\Affective_with_metaphors_pos.txt'  DELIMITER '|' ENCODING 'UTF-8';
COPY Sentences(internal_id, sentence) FROM 'C:\Users\Nucci\Documents\Metatranslator\src\main\database\corpora\FLA2\Affective_with_metaphors_neg.txt'  DELIMITER '|' ENCODING 'UTF-8';

DROP TABLE IF EXISTS Surveys cascade;
CREATE TABLE Surveys (id SERIAL, user_id INTEGER, corpora VARCHAR(3), translator VARCHAR(8), languages VARCHAR(15), num INTEGER, sent1 INTEGER, sent2 INTEGER, sent3 INTEGER, sent4 INTEGER, sent5 INTEGER, sent6 INTEGER DEFAULT NULL, sent7 INTEGER DEFAULT NULL, sent8 INTEGER DEFAULT NULL, sent9 INTEGER DEFAULT NULL, sent10 INTEGER DEFAULT NULL, sent11 INTEGER DEFAULT NULL, sent12 INTEGER DEFAULT NULL, sent13 INTEGER DEFAULT NULL, sent14 INTEGER DEFAULT NULL, sent15 INTEGER DEFAULT NULL, PRIMARY KEY (id), FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY(sent1) REFERENCES Sentences(id) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY(sent2) REFERENCES Sentences(id) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY(sent3) REFERENCES Sentences(id) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY(sent4) REFERENCES Sentences(id) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY(sent5) REFERENCES Sentences(id) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY(sent6) REFERENCES Sentences(id) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY(sent7) REFERENCES Sentences(id) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY(sent8) REFERENCES Sentences(id) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY(sent9) REFERENCES Sentences(id) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY(sent10) REFERENCES Sentences(id) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY(sent11) REFERENCES Sentences(id) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY(sent12) REFERENCES Sentences(id) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY(sent13) REFERENCES Sentences(id) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY(sent14) REFERENCES Sentences(id) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY(sent15) REFERENCES Sentences(id) ON DELETE RESTRICT ON UPDATE CASCADE);
ALTER SEQUENCE surveys_id_seq RESTART WITH 10000 INCREMENT BY 73;

DROP TABLE IF EXISTS Users cascade;
CREATE TABLE Users (id SERIAL, username VARCHAR(50), password VARCHAR(50), firstname VARCHAR(50), surname VARCHAR(50), email VARCHAR(100), PRIMARY KEY (id));

DROP TABLE IF EXISTS SurveyResults cascade;
CREATE TABLE SurveyResults (id SERIAL, sentence INTEGER, group_id INTEGER, correct BOOLEAN, problem_phrase VARCHAR(1000), confidence INTEGER, own_translation VARCHAR(1000), PRIMARY KEY (id), FOREIGN KEY (sentence) REFERENCES Sentences(id) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (group_id) REFERENCES Surveys(id) ON DELETE RESTRICT ON UPDATE CASCADE);

DROP TABLE IF EXISTS UserSurveyRecord cascade;
