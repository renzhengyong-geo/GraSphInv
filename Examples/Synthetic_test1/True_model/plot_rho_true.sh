model=./test_model.nc
rslice=./test_model_r_slice.nc
lonslice1=./test_model_lon_slice1.nc
lonslice2=./test_model_lon_slice2.nc

extract_slice_tool=./Extract_slice
$extract_slice_tool $model $rslice r 6238137
$extract_slice_tool $model $lonslice1 lon 96.5
$extract_slice_tool $model $lonslice2 lon 103.5

Region1=90/110/20/40
Region2=90/110/5978.137/6378.137
Region3=20/40/5978.137/6378.137

#gmt begin slices jpg E300
#	gmt set FONT_TAG 15p
#	gmt set FONT_TITLE 12p
	#gmt set FONT 10p
#	gmt set MAP_FRAME_TYPE plain #fancy+
#	gmt subplot begin 2x2 -Fs6.c/4.c -A+JTL+o-0.0c/-0.c -M1.c/1c # -SRl -SCb # -BWSrt

#		gmt subplot set 0 -A'(a)'
#		gmt basemap -JL100/30/25/35/? -R$Region1 -BWSen+t"400km" -Bafg
#		gmt grdimage $rslice  -E100 -t10 -Q 
#		gmt colorbar -DJBC+h+w5c/0.2c+o0.c/1.0c -Bxaf -By+L"kg/m@3@"
		
#		gmt subplot set 1 -A'(b)'
#		gmt basemap -JPa?/100z -R$Region2 -Bafg -BWNse+t"30\260 N"
#		gmt grdimage  $latslice  -E100 -t10 -Q 
#		gmt colorbar -DJBC+h+w5c/0.2c+o0.c/1.0c -Bxaf -By+L"kg/m@3@"        	        	        
			        

#		gmt subplot set 3 -A'(c)'
#		gmt basemap -JPa?/30z -R$Region3 -Bafg -BWNse+t"110\260 E"
#		gmt grdimage  $lonslice  -E100 -t10 -Q 
#		gmt colorbar -DJBC+h+w5c/0.2c+o0.c/1.0c -Bxaf -By+L"kg/m@3@"
#	gmt subplot end
	#gmt colorbar -DJBC+h+w7c/0.2c+o0.c/1.0c+e -Bxaf -By+L"kg/m@3@" -Cmycpt.cpt
#gmt end show
gmt begin true_model jpg,eps E300
#	gmt set FONT_TITLE 9p
#	gmt set MAP_TITLE_OFFSET 9p 
	gmt set FONT 9p
	gmt set MAP_FRAME_TYPE plain
	gmt set MAP_FRAME_PEN 0.25p,black
	gmt set FORMAT_GEO_MAP ddd:mm:ssF
        gmt makecpt -Cwysiwyg -G0/1 -T-200/200/0.1 -D -Ic  -H > mycpt.cpt
        mycpt=mycpt.cpt
		gmt basemap -JPa4.9c/30z -R$Region3 -Bxafg -Bya200f50g -BWNse
		gmt grdimage  $lonslice2  -E1000 -nn -Q -C$mycpt -Bxafg -Bya200f50g100 -BWNse
		gmt colorbar -DJMR+w4.3c/0.2c+o1c/1.9c+e -Bxa100f20 -By+L"kg/m@+3@+" -C$mycpt
		echo "(c) Longitude=103.5\260 E" | gmt text -F+cTL+f10p, -D0.55c/1.2c -N 	        	        
			        
		gmt basemap -JPa4.9c/30z -R$Region3  -BWNse -Y+3.5c -Bxafg -Bya200f50g+l"km"
		gmt grdimage  $lonslice1  -E1000 -nn -Q -C$mycpt -Bxafg -Bya200f50g100 -BWNse  #nn最邻近插值
		echo "(b) Longitude=96.5\260 E" | gmt text -F+cTL+f10p, -D0.55c/1.2c -N  		

		
		gmt basemap -JL100/30/25/35/3.8c -R$Region1 -BWSen -Bafg -Y-3c -X-5.4c
		gmt grdimage $rslice  -E1000 -nn -Q -C$mycpt -BWSen -Bafg
		#gmt colorbar -DJMR+w4.c/0.2c+o0.5c/0c -Bxaf -By+L"kg/m@+3@+" -C$mycpt
		echo "(a) Depth=140 km" | gmt text -F+cTL+f10p, -D0.5c/0.9c -N
gmt end show

rm $rslice
rm $lonslice1
rm $lonslice2

