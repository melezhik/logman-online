set -e

word=$(config word)
sleep=$(config sleep)

mkdir -p ~/longman-online/$word/mp3

if ! test -f ~/longman-online/$word/data.txt; then
  curl -s http://www.ldoceonline.com/dictionary/$word -o ~/longman-online/$word/data.txt
fi

perl -n -e 'for my $c (/"Play Example"> <\/span>(.*?)<\/span>/g) { $c=~s/<.*?>//g; print $c, "\n" if $c }' \
~/longman-online/$word/data.txt > ~/longman-online/$word/words.txt;

COUNTER=0

for i in $(perl -n -e 'print $_, "\n" for /data-src-mp3="(.*?)"/g' ~/longman-online/$word/data.txt | perl -n -e 'print if /d+/'  ); do
  fbname=$(basename "$i")
  if test -f ~/longman-online/$word/mp3/$fbname; then
    #echo $fbname is already downloaded, skip ...
    :
  else
    curl -s -f http://www.ldoceonline.com/$i -o ~/longman-online/$word/mp3/$fbname  
    #echo ~/longman-online/$word/mp3/$fbname stored
  fi

  COUNTER=$((COUNTER + 1))

  head -"$COUNTER" ~/longman-online/$word/words.txt | tail -1

  audacious -q --headless ~/longman-online/$word/mp3/$fbname >/dev/null

  sleep $sleep
done 




