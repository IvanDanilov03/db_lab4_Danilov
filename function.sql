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