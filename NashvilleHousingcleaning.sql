Select * from NashvilleHousing


--standardize Data format

Select SaleDateConverted convert(date,saledate) as SaleDates
from NashvilleHousing


update NashvilleHousing
set saledate=convert(date,saledate)


Alter table NashvilleHousing
add SaleDateConverted Date;
update NashvilleHousing
set SaleDateConverted =convert(date,saledate)


--populate property Address data

Select *
from NashvilleHousing
where PropertyAddress is null 
order by ParcelID

Select c.ParcelID,c.PropertyAddress,d.parcelID,d.PropertyAddress, isnull(c.propertyAddress, d.propertyAddress)
from NashvilleHousing c
join NashvilleHousing d
on c.ParcelID=d.ParcelID
and c.[UniqueID ] <> d.[UniqueID ]
where c.PropertyAddress is null 

update c
set PropertyAddress=isnull(c.propertyAddress, d.propertyAddress)
from NashvilleHousing c
join NashvilleHousing d
on c.ParcelID=d.ParcelID
and c.[UniqueID ] <> d.[UniqueID ]
where c.PropertyAddress is null 

--breaking out address into individual columns.
Select PropertyAddress
from NashvilleHousing

select 
SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress) -1) as Address
,SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) +1,len(PropertyAddress)) as Address2

from NashvilleHousing

Alter table NashvilleHousing
add PropertySplitAddress Nvarchar(255);

update NashvilleHousing
set PropertySplitAddress=SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress) -1) 

Alter table NashvilleHousing
add PropertySplitCity Nvarchar(255);

update NashvilleHousing
set PropertySplitCity= SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) +1,len(PropertyAddress))



select OwnerAddress
from NashvilleHousing

select parsename (replace(OwnerAddress, ',','.'),3),
parsename (replace(OwnerAddress, ',','.'),2),
parsename (replace(OwnerAddress, ',','.'),1)
from NashvilleHousing

Alter table NashvilleHousing
add ownerSplitAddress Nvarchar(255);

update NashvilleHousing
set ownerSplitAddress=parsename (replace(OwnerAddress, ',','.'),3)

Alter table NashvilleHousing
add ownerSplitCity Nvarchar(255);

update NashvilleHousing
set ownerSplitCity= parsename (replace(OwnerAddress, ',','.'),2)

Alter table NashvilleHousing
add ownerSplitstate Nvarchar(255);

update NashvilleHousing
set ownerSplitstate= parsename (replace(OwnerAddress, ',','.'),1)


--change Y and n to yes and no in 'sold as vacant' field
Select distinct(soldAsVacant),count (soldasvacant)
from NashvilleHousing
group by SoldAsVacant


Select  SoldAsVacant,
case when SoldAsVacant ='Y' then 'Yes'
     when soldasvacant = 'N' then 'No'
     else soldasvacant
end
from NashvilleHousing

update NashvilleHousing
set soldasvacant = case when SoldAsVacant ='Y' then 'Yes'
     when soldasvacant = 'N' then 'No'
     else soldasvacant
end


--remove Duplicates

with RowNumCTE as (
select *,row_number() over (partition by ParcelID, propertyAddress,saleprice,saledate,legalreference
order by uniqueID) row_num

from NashvilleHousing

--where parcelid='081 15 0 472.00'
--order by ParcelID 
)
delete from RowNumCTE
where row_num>1
--order by ParcelID 




--delete unused columns
alter table NashvilleHousing
drop column owneraddress