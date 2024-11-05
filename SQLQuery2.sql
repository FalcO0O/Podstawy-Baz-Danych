use library


--Æwiczenie 1
select title, title_no from title
select title, title_no from title where title_no = 10
select title_no, author from title where author in ('Charles Dickens', 'Jane Austen')

--Æwiczenie 2
select title_no,title from title where title like '%adventure%'
select member_no as Numer, Isnull(fine_paid, 0) as Koszt from loanhist order by fine_paid DESC
select member_no, sum(fine_paid) as total_fine_paid from loanhist --drugi sposób / lepszy
	where fine_paid is not null 
	group by member_no;
select distinct city, state from adult order by state, city
select title from title order by title

-- Æwiczenie 3
select member_no, isbn, fine_assessed from loanhist 
	where fine_assessed is not null and fine_assessed > 0 order by fine_assessed desc
select fine_assessed * 2 as [double fine] from loanhist 
	where fine_assessed is not null order by [double fine] desc

-- Æwiczenie 4
select firstname + ' ' + middleinitial + ' ' + lastname as email_name from member where lastname = 'Anderson'
select LOWER(firstname + middleinitial + substring(lastname,1,2)) 
	as [Lista proponowanych adresów e-mail] from member

-- Æwiczenie 5
select 'The title is: ' + title + ', Title number: ' + str(title_no) from title					-- 1.
select concat('The title is ', title, ', Title number: ', title_no) from title					-- 2.
select FORMAT(title_no, '0') as																	-- 3.
	Title_no, 'The title is: ' + title + ', Title number: ' + FORMAT(title_no, '0') FROM title; 


