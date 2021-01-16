echo "Preaparing for file transfer..."
if [ $# -eq 0 ]
  then
    echo "No arguments supplied, using tost directory"
    destination_directory="tost"
else
    destination_directory=$1
fi

echo "Organizing the files..."
mkdir -p ${destination_directory}
rm -rf ${destination_directory}/*
mkdir -p ${destination_directory}/cheatsheets/sans
cp cheatsheets_list/missing_sans.list ${destination_directory}/cheatsheets/sans
cp cheatsheets_list/misc.list ${destination_directory}/cheatsheets/
cd ${destination_directory}

echo "Downloading github..."
git clone https://github.com/BushidoUK/Open-source-tools-for-CTI
git clone https://github.com/jivoi/awesome-osint
git clone https://github.com/megadose/holehe

echo "Downloading cheatsheets..."
cd cheatsheets
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
sed -i -e 's/^/https:\/\/digital-forensics.sans.org\//' ready_to_sed
wget https://www.sans.org/blog/the-ultimate-list-of-sans-cheat-sheets/
cat index.html | grep -o -P "https:[^\>]*?\.pdf.*?\"" >> ready_to_sed
sed 's/.$//' ready_to_sed > seded
cat missing_sans.list >> seded
sort seded | uniq > all_sans_cheatsheets.list

wget -i all_sans_cheatsheets.list
rm missing_sans.list index.html ready_to_sed seded 'cheat-sheets?msc=Cheat+Sheet+Blog'

echo "Checking for compromised files..."
cd ../..
clamscan -r --bell -i ./

echo "All files in place."
