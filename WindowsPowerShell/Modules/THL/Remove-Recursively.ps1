 function Remove-Recursively ($folderName) {
     ls . -inc $folderName -R | rm -R -fo 
 }
