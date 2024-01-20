CREATE VIEW sertifika AS
SELECT cr.basvuran_id, cpr.sertifika_adi, cr.sertifika_id, cmp.company_name
FROM sertifika_basvuru cr, sertifika_programlari cpr, company cmp
WHERE cr.sertifika_id = cpr.sertifika_id and cpr.company_id = cmp.company_id;

-------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION get_userID()
RETURNS INTEGER AS $$
DECLARE
  maxUserID INTEGER;
  sequenceName TEXT;
  nextValResult INTEGER;
  shouldIncrement BOOLEAN;
BEGIN
  SELECT MAX(UserID) INTO maxUserID FROM Kullanici;
  sequenceName := 'seq_' || (maxUserID + 1);
  shouldIncrement := FALSE;
  IF NOT EXISTS (SELECT 1 FROM information_schema.sequences WHERE sequence_name = sequenceName) THEN
    EXECUTE 'CREATE SEQUENCE ' || sequenceName || ' START WITH ' || (maxUserID + 1) || ' INCREMENT BY 1';
    shouldIncrement := TRUE;
  END IF;
  IF shouldIncrement THEN
    EXECUTE 'SELECT nextval(''' || sequenceName || ''')' INTO nextValResult;
    RETURN nextValResult;
  ELSE
    RETURN maxUserID + 1; 
  END IF;
END;
$$ LANGUAGE plpgsql;


-------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION generate_nickname(p_userID integer, p_fname varchar, p_lname varchar) 
RETURNS varchar AS $$
DECLARE
    nickname varchar;
BEGIN
    nickname := p_fname || p_lname || p_userID;
    RETURN nickname;
END;
$$ LANGUAGE plpgsql;


-------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TYPE guncel1 AS (new_okul varchar(30), new_dept varchar(30), new_deneyim varchar(30), new_email varchar(30));

CREATE OR REPLACE FUNCTION profil_guncelle2(kullanici_id INT, new_okul VARCHAR(30), new_dept VARCHAR(30), new_deneyim VARCHAR(30), new_email VARCHAR(30))
RETURNS guncel1 AS $$
DECLARE 
    profil_bilgi guncel1;
    profil_cursor CURSOR FOR SELECT usr_id, okul, department, deneyim, email FROM profil WHERE usr_id = kullanici_id FOR UPDATE;
BEGIN 
    FOR profil_row IN profil_cursor
    LOOP
        -- Her bir kayıt için güncelleme işlemi yap
        UPDATE profil 
        SET okul = new_okul, department = new_dept, deneyim = new_deneyim, email = new_email 
        WHERE usr_id = profil_row.usr_id
        RETURNING okul, department, deneyim, email INTO profil_bilgi;
        RETURN profil_bilgi;       -- Güncellenen bilgiyi döndürür
    END LOOP;
END;
$$ LANGUAGE 'plpgsql';

-------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION get_company_name(companyId int, OUT comp_name varchar(20))
RETURNS varchar(20) AS $$
BEGIN
    SELECT company_name INTO comp_name FROM company WHERE company_id = companyId;
END;
$$ LANGUAGE plpgsql;

-------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION sirket_id_kontrol()
RETURNS TRIGGER AS $$
DECLARE
    found_company integer := 0;
    companyID integer := new.company_id;
    cursor_companies CURSOR FOR SELECT company_id FROM company;
BEGIN
    FOR c_row IN cursor_companies LOOP
        IF c_row.company_id = companyID THEN
            found_company := 1;
            RAISE WARNING 'Şirket ID eşsiz olmalı. Bu şirket ID kayıtlı başka bir şirkete aittir.';
            RETURN NULL;
        END IF;
    END LOOP;
    IF found_company = 0 THEN
        RAISE INFO 'Yeni şirket eklendi.';
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER sirket_id_kontrol_trigger
BEFORE INSERT ON company
FOR EACH ROW
EXECUTE FUNCTION sirket_id_kontrol();

-------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION sertifika_sirket_id_kontrol()
RETURNS TRIGGER AS $$
BEGIN
    IF (SELECT company_id FROM company WHERE company_id = new.company_id) IS NOT NULL THEN
        RAISE WARNING 'Kayıt başarılı.';
        RETURN NEW;
    ELSE 
        RAISE INFO 'Şirket ID kayıtlı değil!';
        RAISE INFO 'Kayıtlı bir Şirket ID ile sertifika programı ekleyebilirsiniz.';
        RETURN NULL;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER sertifika_sirket_id_kontrol_trigger
BEFORE INSERT ON sertifika_programlari
FOR EACH ROW
EXECUTE FUNCTION sertifika_sirket_id_kontrol();

