/*
    Function per aggiungere un attributo ad un json
    Se il json sorgente è una stringa vuota crea il json da zero, altrimenti aggiunge l'attributo alla struttura esistente
    INPUT: 
        - json_ TEXT: Json originale; può essere una stringa vuota per un nuovo json
        - attr_name TEXT: nome dell'attributo da inserire nel json
        - attr_val TEXT: valore dell'attributo da inserire; può essere un dato atomico, un altro json o un json array
        - quotes INT(1): 1 se il valore dell'attributo deve essere tra virgolette (solo per le stringhe), 0 altrimenti (int, boolean, json object, json array)

    OUTPUT: 
        - json TEXT

    ESEMPIO: 
      select json_append(json_append('', 'ciccio', '{"pasticcio": "fatto"}', 0), 'piripiccio', '10', 1) =>  {
                                                                                                                "ciccio":{
                                                                                                                    "pasticcio": "fatto"
                                                                                                                    },

                                                                                                                "piripiccio":"10"
                                                                                                            } 
*/

drop function if exists json_append;

delimiter $$

create function json_append(json_ text, attr_name text, attr_val text, quotes int(1)) RETURNS text
    deterministic
begin

    declare value_ text;

    if quotes = 1 then
        set value_ = concat('"', attr_val, '"');
    else
        set value_ = attr_val;
    end if;

    if length(json_) = 0 then
        return concat('{"', attr_name, '":', value_, '}');
    else
        return concat(SUBSTRING(json_, 1, length(json_) - 1), ',"', attr_name, '":', value_, '}');
    end if;

end $$

delimiter ;
