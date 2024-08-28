
registration(){
	echo
	#echo "	this is the registaration function"
	echo
	read -p "	Enter the student ID: " id
	read -p "	Enter the student name: " name
	read -p "	Enter the Batch: " batch
	read -p "	Enter the department: " dept
	read -p "	Enter the user name: " user
	read -s -p "	Enter the password: " pass
	echo "$id	$name		$batch	$dept" >> student.txt
	echo "$id	$name		$batch	$dept		$user		$pass" >> admin.txt
	echo
	echo
	echo "	Registration successfully"

}

login(){
	echo
	#echo "	this is the login function"
	echo
	#read -p "	Enter the user name: " loguser
	read -p "	Enter the student ID: " logid
	read -s -p "	Enter the password: " logpass
	lid=0
	lpas=0

	while read c1 c2 c3 c4 c5 c6
	do
		if [ $logid == $c1 ] && [ $logpass == $c6 ]
		then
			lid=$c1
			lpass=$c6
			echo
			echo
			echo "	login successfully"
		fi
	done < admin.txt
	if [[ $lid == 0 ]]
	then
		echo
		echo "	incorred password"
		echo "	please try again"
	fi
}

display(){
	#echo "	this is the display function"
	echo
	cat bookList.txt
}

addbook(){
	#echo "	this is the addBook function"
	echo
	read -p "	Enter the book catagory: " cata
	read -p "	Enter the author name: " author
	read -p "	Enter the book title: " title
	#sed -i "$a $cata	$author		$title" add.txt
	echo "$cata		$author		$title" >> bookList.txt
	echo
	echo
	echo "	Add successfully"
}

search(){
	#echo "	this is the search function"
	echo
	read -p "	Enter the title name: " stitle
	s=0
	la=()
	lc=()
	lt=()
	no=0
	while read c1 c2 c3
	do
		#echo "	column2: $c2"
		if [[ $stitle == $c3 ]]
		then
			lc[$no]=$c1
			la[$no]=$c2
			lt[$no]=$c3
			s=$(( $s +1 ))
			no=$(( $no + 1 ))
		fi
	done < bookList.txt

	if [[ $s == 0 ]]
	then
		echo
		echo "	this book is not found in library"
		echo
	else
		echo
		echo "	This book is found "
		echo "	No. of $s books are available in library"
		echo
		echo "	Catagory	AuthorName	Title  "
		echo "	--------	-----------	--------"
		p=0
		while [ $p -lt ${#la[@]} ]
		do
			aa=${lc[$p]}
			bb=${la[$p]}
			cc=${lt[$p]}
			#echo "$aa"
			#echo "$bb"
			#echo "$cc"
			echo "	$aa		$bb		$cc"
			#echo "${listCatagory[$z]}	${listAuthor[$z]}	${listTitle[$z]}"
			#echo "	a;lsdka;sld"
			p=`expr $p + 1`
		done

	fi
}

studentlist(){
	#echo "	this is the studentList function"
	echo
	p=1
	q=4
	while [[ $p -lt $q ]]
	do
		echo "	Display the student list for: "
		echo "	1. Student side"
		echo "	2. Admin side"
		read -p "	Choose any option: " ch
		if [[ $ch == 1 ]]
		then
			echo
			cat student.txt
			echo
			break
		elif [[ $ch == 2 ]]
		then
			echo
			x=1
			y=5
			while [[ $x -lt $y ]]
			do
				read -s -p "	Enter the admin password: " pa
				echo
				if [[ $pa == shahdat ]]
				then
					echo
					cat admin.txt
					echo
					p=$q
					break
				else
					echo
					echo
					echo "	please try again"
					echo
					x=$(( $x+1))
					if [[ $x == 4 ]]
					then
						break
					fi
				fi
			done
		else
			echo
			echo
			echo "	Please try again "
			echo
			p=$(( $p + 1))
			if [[ $p == 4 ]]
			then
				break
			fi
		fi
		#cat student.txt
	done
}


removestudent(){
	#echo "	this is the take book function"
	echo
	read -p "	Do you want to remove (yes/no): " ch
	if [[ $ch == yes ]]
	then
		read -p "	Enter the deleating id: " did
		read -s -p "	Enter the admin  password : " apass
		if [ mithu == $apass ]
		then
			sed -i "/$did/d" admin.txt
			sed -i "/$did/d" student.txt
			echo
			echo
			echo "	Remove successfully"
		else
			echo
			echo
			echo "	Pass invalid"
			echo
		fi
	fi
}

takebook(){
	#echo "	this is the take book function"
	echo
	t=1
	tt=2
	line=0
	#dline=0
	count=1
	while [ $t -lt $tt ]
	do
		read -p "	Do you want ot perches book (yes/no): " per
		if [[ $per == yes ]]
		then
			read -p "	Enter the book catagory name: " tcat
			read -p "	Enter the book author name: " tau
			read -p "	Enter the book title name: " tti

			while read x1 x2 x3
			do
				if [ "$x1" = "$tcat" ] && [ "$x2" = "$tau" ] && [ "$x3" = "$tti" ]
				then
					line=$count
				fi
				#echo "	no. of line: $count"
				count=$(($count+1))
			done < bookList.txt
			if [ $line == 0 ]
			then
				echo
				echo
				echo "	this book is not found in library"
				echo
			else
				#sed -i "${line}s/$tau/$tcat/" "bookList.txt"

				sed -i "${line}d" "bookList.txt"
				#echo "line number is : $line"
				echo
				echo
				echo "	perches successfully"
				echo
			fi
		else
			t=2
		fi
	done
}

edit(){
	echo
	#echo "	this is the pass change function."
	echo
	echo "	this is the id : $1"
	id=$1
	i=0
	cou=1
	read -p "	Do you want to change password (yes/no): " ch
	if [ $ch == yes ]
	then
		read -s -p "	Enter the old password: " opass
		echo
		read -p "	Enter the new password: " npass

		while read a1  a2 a3 a4 a5 a6
		do
			if [[ $a1 == $id ]]
			then
				i=$cou
				#echo "	line no. is $i" 
				if [ $opass == $a6 ]
				then
					sed -i "${i}s/$opass/$npass/" "admin.txt"
					echo
					echo
					echo "	pass change successfully"
					#echo "	done"
				fi
			fi
			cou=$(($cou+1))
		done < admin.txt
	fi
}


echo
echo
echo "	-----Welcome to Library Management system-----"
i=1
n=2
while [ $i -lt $n ]
do
	echo
	echo "	Do you want to Registration or Login: "
	echo "	1. Registration"
	echo "	2. Login"

	read -p "	Enter the choose any one: " ch
	if [[ $ch == 1 ]]
	then
		registration

	elif [[ $ch == 2 ]]
	then
		login
		i=$lid
	else
		echo
		echo
		echo "	Please choose a correct option"
		echo "	try again"
		echo
	fi
done


j=0
k=2

while [ $j -lt $k ]
do
	echo
	echo "	-------Home Page------"
	echo "	1. Display Book List"
	echo "	2. Add Book"
	echo "	3. Search Book"
	echo "	4. Register Student list"
	echo "	5. Remove Student"
	echo "	6. Take Book"
	echo "	7. Registration"
	echo "	8. Change password"
	echo "	0. Exit"
	echo

	read -p "	Please choose any one: " choose
	if [[ $choose == 1 ]]
	then
		display
	elif [[ $choose == 2 ]]
	then
		addbook
	elif [[ $choose == 3 ]]
	then
		search
	elif [[ $choose == 4 ]]
	then
		studentlist
	elif [[ $choose == 5 ]]
	then
		removestudent
	elif [[ $choose == 6 ]]
	then
		takebook
	elif [[ $choose == 7 ]]
	then
		registration
	elif [[ $choose == 8 ]]
	then
		edit $lid
	elif [[ $choose == 0 ]]
	then
		echo
		echo
		echo "	program is completed"
		echo
		break
	else
		echo
		echo "	Choose the correct option "
		echo "	please try again"
	fi
done
