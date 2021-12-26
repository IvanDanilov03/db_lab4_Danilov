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