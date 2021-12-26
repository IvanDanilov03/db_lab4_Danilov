--function 
CREATE OR REPLACE FUNCTION count_comics_by_author(writer_id_n text) RETURNS int 
LANGUAGE 'plpgsql'
AS
$$
    DECLARE
        number_of_comics int;
    BEGIN
        SELECT COUNT(comics_name) INTO number_of_comics
        FROM Comics WHERE Comics.writer_id = writer_id_n;
        RETURN number_of_comics;
    END;
$$;
SELECT count_comics_by_author('WR1')


--procedure

CREATE OR REPLACE PROCEDURE find_comics_information_vs(comics_id_n text)
LANGUAGE 'plpgsql'
AS $$
	DECLARE
		found_comics record;
    BEGIN
        FOR found_comics IN
            (SELECT * FROM Comics 
            join Publish using(publish_id)
            join Format using(format_id)
            join Writer using(writer_id)
            WHERE  comics_id = comics_id_n)
        LOOP 
            RAISE INFO 'Comics: %', found_comics;
        END LOOP;
    END;
$$;
CALL find_comics_information_vs('COM2');
select * from found_comics;


--trigger
CREATE OR REPLACE FUNCTION insert_release()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
BEGIN
  UPDATE Comics 
  SET comics_name = 'Release ' || NEW.comics_name WHERE comics_id = NEW.comics_id; 
  RETURN NULL;
END;
$$;

CREATE TRIGGER insert_release_trigger
  AFTER INSERT
  ON Comics
  FOR EACH ROW
  EXECUTE PROCEDURE insert_release();
  
  
 
INSERT INTO Comics
VALUES('COM12', 'FOR4', 'WR3', '03', 'Test trigger', 'Age Of New Spider Man (2021) #1', 'THE AGE OF Spider Man CONCLUDES! As twilight falls on the Age of X-Man, the X-Men are forced to decide wh...');
Select * from Comics
