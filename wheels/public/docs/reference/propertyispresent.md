```coldfusion
propertyIsPresent(property)
```
```coldfusion
// Get an object, set a value and then see if the property exists
employee = model("employee").new()>
employee.firstName = "dude">
<cfreturn employee.propertyIsPresent("firstName")>// Returns true

employee.firstName = "">
<cfreturn employee.propertyIsPresent("firstName")>// Returns false
```