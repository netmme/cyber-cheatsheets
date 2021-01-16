echo "Preaparing for file transfer..."
if [ $# -eq 0 ]
  then
    echo "No arguments supplied, using tost directory"
    doc_directory="tost"
else
    doc_directory=$1
fi

mkdir -p ${doc_directory}
#rm -rf $1/*
mkdir -p $1/cheatsheets/sans
cp cheatsheets_list/missing_sans $1/cheatsheets/sans
cp cheatsheets_list/misc $1/cheatsheets/
cd $1

echo "Downloading github..."
git clone https://github.com/BushidoUK/Open-source-tools-for-CTI
git clone https://github.com/jivoi/awesome-osint
git clone https://github.com/megadose/holehe

echo "Organizing cheatsheets..."
cd cheatsheets

echo "Downloading cheatsheets..."
wget -i misc.list

# Owasp cheatsheets 
wget https://cheatsheetseries.owasp.org/bundle.zip
unzip -o bundle.zip
rm bundle.zip
mv site owasp-cheatsheets

# Sans cheatsheets
cd sans
wget https://digital-forensics.sans.org/community/cheat-sheets?msc=Cheat+Sheet+Blog
cat 'cheat-sheets?msc=Cheat+Sheet+Blog' | grep -o -P "\/media[^\>]*?\.pdf.*?\'" > ready_to_sed
cp ready_to_sed ready1
sed -i -e 's/^/https:\/\/digital-forensics.sans.org\//' ready_to_sed
cp ready_to_sed ready2

wget https://www.sans.org/blog/the-ultimate-list-of-sans-cheat-sheets/
cat index.html | grep -o -P "https:[^\>]*?\.pdf.*?\"" >> ready_to_sed
sed 's/.$//' ready_to_sed > seded
cat missing_sans >> seded
sort seded | uniq > all_sans_cheatsheets.list

wget -i all_files
rm missing_sans index.html ready_to_sed seded 'cheat-sheets?msc=Cheat+Sheet+Blog'

echo "All files in place."
