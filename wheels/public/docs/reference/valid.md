```coldfusion
// Check if a user is valid before proceeding with execution
user = model("user").new(params.user)>
<cfif user.valid()>
    // Do something here
</cfif>
```