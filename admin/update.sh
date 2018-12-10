#!/bin/bash
ROOT="/var/www/html/repo"
DIRS=($(cat "$ROOT/admin/dirs.conf")) # adjust the available directories in dirs.conf
ZIP="$(command -v zip)"
UNZIP="$(command -v unzip)"

echo ""
echo "░█▀▄░█▀▀░█▀█░█▀█░░░█░█░█▀█░█▀▄░█▀█░▀█▀░█▀▀░█▀▄"
echo "░█▀▄░█▀▀░█▀▀░█░█░░░█░█░█▀▀░█░█░█▀█░░█░░█▀▀░█▀▄"
echo "░▀░▀░▀▀▀░▀░░░▀▀▀░░░▀▀▀░▀░░░▀▀░░▀░▀░░▀░░▀▀▀░▀░▀"
echo ""
echo ""

if [ "$ZIP" = "" ]
then
	echo "zip missing. eg: apt-get install zip"
	exit 0
fi

if [ "$ZIP" = "" ]
then
        echo "unzip missing. eg: apt-get install unzip"
        exit 0
fi

unzip_uploads() {
        for zip in $(find . -maxdepth 1 -type f | grep .zip | cut -d \/ -f 2); do
		echo ""
	        echo "Process upload: $zip"
        	unzip -o "$zip" >/dev/null 2>&1 && rm "$zip" >/dev/null 2>&1
		echo ""
        done
}

generate_repo() {
	echo ""
        echo '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>' >addons.xml
        echo '<addons>' >> addons.xml

        for name in $(find . -maxdepth 1 -type d | grep -v \.git | grep -v addons | egrep -v "^\.$" | cut -d \/ -f 2); do
            	if [ -f "$name/addon.xml" ]; then
                	VERSION=$(cat $name/addon.xml | grep \<addon | grep $name | tr 'A-Z' 'a-z' | sed 's/.*version="\([^"]*\)"*.*/\1/g')
	                if [ ! -f "$name/$name-$VERSION.zip" ]; then
               		        echo "Create: $kodibuild/$name-$VERSION.zip"
	                        zip -r "$name/$name-$VERSION.zip" "$name" -x \*.zip -x \*.git -x \*.psd -x \*.pyo -x \*.gitignore >/dev/null 2>&1
	                        echo ""
	                fi
	                find "$name" ! \( -name "addon.xml" -o -name "*.zip" -o -name "fanart.jpg" -o -name "icon.png" -o -name "screenshot*.*" \) -delete >/dev/null 2>&1
	                echo "Add: $name $VERSION"
			echo ""
			oldfiles=($(ls -A1t "$name/" | grep .zip | tail -n +11))
			if ! [ -z "$oldfiles" ]; then
				echo "Cleanup: Delete older versions of $name"
				echo ""
				for archive in "${oldfiles[@]}"; do
					rm "$name/$archive"
				done
			fi
			cat "$name"/addon.xml|grep -v "<?xml " >> addons.xml
	                echo "" >> addons.xml
	    	fi
        done

        echo "</addons>" >> addons.xml
        md5sum addons.xml > addons.xml.md5
}

for kodibuild in "${DIRS[@]}"; do
	if [ -d "$ROOT/$kodibuild" ]; then
		echo "${kodibuild^^}"
		echo ""
		cd "$ROOT/$kodibuild"

		if [ "$1" != "generate" ]; then
			unzip_uploads
		fi
		if [ "$1" != "unzip" ]; then
			generate_repo
		fi

		echo "-------------------"
		echo ""
	fi
done

echo "Done"

