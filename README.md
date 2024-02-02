# ImgurToAO3
Convert the HTML markup of your [Imgur](https://imgur.com/) posts into a format that works on [Archive Of Our Own](https://archiveofourown.org/). 

Ideal for comics and other sequential, visual works.

✏️ The images must remain uploaded on Imgur, as AO3 does not provide image hosting. This simply allows them to be displayed as a work.

## Instructions

1. Sign in to imgur and edit the post you want to transfer.
   - You must be **editing a post *you own***, or else there aren't distinguishing markers between the posts's content and the other miscellaneous images on the page.
   - Getting them in the correct order of the imgur post itself is its own beast, and I can't really help you there 😅
   ![altText](/screenshots/SS01.png)
1. ***Inspect*** the page and copy the markup
   - Since imgur loads in a bunch of stuff with javascript after the page initially loads, viewing the full page source normally doesn't work.

   ![altText](/screenshots/SS02.png)
   ![altText](/screenshots/SS03.png)

1. Save the markup to a new html file.

   ![altText](/screenshots/SS04.png)
   ![altText](/screenshots/SS05.png)
   ![altText](/screenshots/SS06.png)
   ![altText](/screenshots/SS07.png)

1. [Optional] If you have wrapping images that will be reused across several episodes, coming before and after the dynamic content (like a title card or end credit screen), paste their URLs into text files, each URL on a new line. 

   ![altText](/screenshots/SS08.png)
   ![altText](/screenshots/SS09.png)
   ![altText](/screenshots/SS10.png)

1. Open powershell
   - You can do this by typing `powershell` into the file explorer address bar.
   ![altText](/screenshots/SS11.png)
1. Run the script 
   1. Pass the html file to the `SourcePath` parameter.
   1. [Optional] Pass the wrapping files to the `ImagesBeforePath` and `ImagesAfterPath` parameters.
   1. Pass the name of the file you want to generate to the `OutputFileName` parameter.
   ![altText](/screenshots/SS12.png)
   ![altText](/screenshots/SS13.png)
1. Copy the new markup from the output file into your work on AO3
    - Make sure to use the HTML editor
   ![altText](/screenshots/SS14.png)
   ![altText](/screenshots/SS15.png)
   ![altText](/screenshots/SS16.png)

   
