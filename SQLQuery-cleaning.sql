--Seeing the data

select * from PortfolioProject..NashvilleHousing

--standardize saledate

select SaleDate from PortfolioProject..NashvilleHousing

ALTER TABLE NashvilleHousing
ADD updated_date date

update NashvilleHousing
set updated_date=CONVERT(date,SaleDate)

select updated_date from NashvilleHousing

--filling NULL values in Property Address

select * from NashvilleHousing
--where PropertyAddress is null
order by ParcelID

--ParcelIDs are same but they are in different rows
select * from 
NashvilleHousing a inner join NashvilleHousing b
on a.ParcelID=b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]

--seeing in which rows PropertAddress is NULL for the same parcelID
select a.ParcelID,a.[UniqueID ],a.PropertyAddress,b.ParcelID,b.[UniqueID ],b.PropertyAddress from 
NashvilleHousing a inner join NashvilleHousing b
on a.ParcelID=b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null --or b.PropertyAddress

--Now populating the null with the address
select a.ParcelID,a.[UniqueID ],a.PropertyAddress,b.ParcelID,b.[UniqueID ],b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
from NashvilleHousing a inner join NashvilleHousing b
on a.ParcelID=b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null

update a
set a.PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
from NashvilleHousing a inner join NashvilleHousing b
on a.ParcelID=b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null

--checking
select a.ParcelID,a.[UniqueID ],a.PropertyAddress,b.ParcelID,b.[UniqueID ],b.PropertyAddress
from NashvilleHousing a inner join NashvilleHousing b
on a.ParcelID=b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null

--Breaking Address into Individual Coloumns (Address, City, State)

select PropertyAddress from PortfolioProject..NashvilleHousing

select PARSENAME(replace(PropertyAddress, ',','.'),2) ,
PARSENAME(replace(PropertyAddress, ',','.'),1) from NashvilleHousing

ALTER TABLE NashvilleHousing
ADD PropertyAddress1 varchar(300)

update NashvilleHousing
set PropertyAddress1=PARSENAME(replace(PropertyAddress, ',','.'),2)

ALTER TABLE NashvilleHousing
ADD PropertyCity varchar(300)

update NashvilleHousing
set PropertyCity=PARSENAME(replace(PropertyAddress, ',','.'),1)

select * from NashvilleHousing

--same for owner address
--looking for NULL with address
select a.[UniqueID ], a.ParcelID,a.OwnerAddress,b.[UniqueID ], b.ParcelID,b.OwnerAddress 
 from NashvilleHousing a inner join NashvilleHousing b on a.ParcelID=b.ParcelID	
 and a.[UniqueID ]<>b.[UniqueID ]
 where a.OwnerAddress is null

 --removing empty values
 DELETE from NashvilleHousing where OwnerAddress is null

 select * from NashvilleHousing

 --Breaking Address into Individual Coloumns (Address, City, State)
 select OwnerAddress from NashvilleHousing

 select parsename(replace(OwnerAddress,',','.'),3),
  parsename(replace(OwnerAddress,',','.'),2),
   parsename(replace(OwnerAddress,',','.'),1)
 from NashvilleHousing

 Alter table NashvilleHousing
 add OwnerAddress1 varchar(300)

 update NashvilleHousing
 set OwnerAddress1=parsename(replace(OwnerAddress,',','.'),3)

 Alter table NashvilleHousing
 add OwnerCity varchar(300)

  update NashvilleHousing
 set OwnerCity=parsename(replace(OwnerAddress,',','.'),2)

  Alter table NashvilleHousing
 add OwnerState varchar(300)

   update NashvilleHousing
 set OwnerState=parsename(replace(OwnerAddress,',','.'),1)

 select * from NashvilleHousing

 --Change Y and	N to Yes and No in Sold as vacant

 select distinct(SoldAsVacant), count(SoldAsVacant) from NashvilleHousing
 group by SoldAsVacant
 order by 2

 select SoldAsVacant,
 CASE when SoldAsVacant ='Y' THEN 'Yes'
	  when SoldAsVacant ='N' THEN 'No'
	  ELSE SoldAsVacant
	  END
 from NashvilleHousing

 update NashvilleHousing
 set SoldAsVacant = 
 CASE when SoldAsVacant ='Y' THEN 'Yes'
	  when SoldAsVacant ='N' THEN 'No'
	  ELSE SoldAsVacant
	  END

select SoldAsVacant from NashvilleHousing

--Delete unused coloumns

select * from NashvilleHousing

alter table NashvilleHousing
drop column  PropertyAddress, TaxDistrict, SaleDate


select * from NashvilleHousing


