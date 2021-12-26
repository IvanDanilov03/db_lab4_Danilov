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
