# Поиск нужной инфо.
                                                                 # $2 -C найденая строка + несколько строк до и после нее
                                                                 # /d/QA/search.sh "select" "7" формат запроса
grep -RiC"$2" "$1" /d/QA/git/Andrew-Valiev/* > /d/QA/f6.txt      # выполнить поиск и сохранить в файле
 sed " 
       s/${1}/\x1B[31m&\x1B[0m/ig;                               # \x1B[31m&\x1B[0m измение цвета искомого параметра | i без учета регистра | g замена по всей строке
       s/bash_scripts/B_S/;                                      # сокращение названия директории на B_S -
       s/.md/ | /;                                               # замена расширения на |
       s/\/d\/QA\/git\/Andrew-Valiev/*/;
       s/sql_queries/../;
       s/sql/\x1B[36m&\x1B[0m/;
       s/my_scripts/m_s/;
       s/.sh/ | /; 
                                                                 # замена ссылки Linkbash
        /SUVORK5CYII%3D/c -------------------------------------- 
     "  /d/QA/f6.txt
