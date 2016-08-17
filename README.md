# dvTravel
dvTravel is a a Windows and soon to be iPad application made for Casa Dulce Vida (www.dulcevida.com/), a “boutique hotel” in Mexico, to manage their client's bookings and payments.

The client application connects to a middle-tier server connected to the database, which processes and returns the results to the client. Both the middle-tier server and the database itself are hosted on Amazon Web Services.

It does have offline functionality allowing the user to add bookings or clients while offline, but this is relatively limited, as the application is designed more to handle occasional lapses in internet rather than to be actually used while offline.

Made for and tailored to a specific client but could be easily generalized for a more typical hotel or resort.

It is based off a previous application that ended up being used for 15 years, and this version was designed to be somewhat familiar while also adding new features and being easier to use. Nonetheless, there are some weird design things that I might not have done otherwise.

This code won't actually work properly and no executables are supplied because the database, server, and connections between all the different parts (database, server, and client) are all not properly set up in this because the information used for that is private. However otherwise all the code is the same as what is running in the video demo (www.youtube.com/watch?v=yDamSvKMYF8)

#Reading Delphi
Delphi is an IDE with a visual form designer, so without actually owning Delphi and being able to open the project it can be a bit hard to read.
The .pas files are the main code parts, though they often rely on objects in the forms, defined in the .fmx files.

#Github Repository Code
This code won't actually work properly and no executables are supplied because the database, server, and connections between all the different parts (database, server, and client) are all not properly set up in this because the information used for that is private. However otherwise all the code is the same as what is running in the video demo (www.youtube.com/watch?v=yDamSvKMYF8)

The whole project is in two applications:

dvTravelServer: The middle-tier server that connects the database and the client and processes the information between. On the actual version it is running on an Amazon Web Services instance.

dvTravelClient: The client application used by the user. Manages bookings, payments, and invoices. Application is split into 4 tabs, Home, Clients, Bookings, Calendar.	
