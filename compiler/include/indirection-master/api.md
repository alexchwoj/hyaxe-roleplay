indirection
==========================================
Function pointers and code redirection.
------------------------------------------
Copyright (c) 2022 Alex "Y_Less" Cole. Licensed under MPL 1.1

Indirection is a system for calling function pointers in a generic and type-safe way. Instead of `CallLocalFunction`, `Call`, `defer`, `Callback_Call`, or any other method, this gives one common interface which can be extended by library authors; utilising tags for compile-time parameters.




## Functions


### `Indirect_Call`:


#### Syntax


```pawn
Indirect_Call(func, tag, ...)
```


#### Parameters


| 	**Name**	 | 	**Info**	 |
|	---	|	---	|
| 	`func`	 | 		 |
| 	`tag`	 | 		 |
| 	`...`	 | 	` {_,Bit,Text,Group,File,Float,Text3D} `	 |

#### Estimated stack usage
1 cells



### `Indirect_Claim_`:


#### Syntax


```pawn
Indirect_Claim_(func)
```


#### Parameters


| 	**Name**	 | 	**Info**	 |
|	---	|	---	|
| 	`func`	 | 	The function pointer you want to use later.	 |

#### Remarks
If a function pointer is used within one function, that is not a problem. However, if you want to store the function pointer for use later, you must first "claim" it, so that any associated data is not cleared when the parent function ends (i.e. the function that called your function). After use it must be released, and the number of claims must match the number of releases.


#### Depends on
* [`gsCodSize`](#gsCodSize)
#### Estimated stack usage
1 cells



### `Indirect_DePtr_`:


#### Syntax


```pawn
Indirect_DePtr_(ptr)
```


#### Parameters


| 	**Name**	 | 	**Info**	 |
|	---	|	---	|
| 	`ptr`	 | 		 |
| 	``	 | 	The array to convert to an offset pointer.	 |

#### Remarks
Strings and arrays are passed relative to `COD` not `DAT` so they can be distinguished from normal function pointers. This function does the offset.


#### Depends on
* [`gsCodSize`](#gsCodSize)
#### Estimated stack usage
1 cells



### `Indirect_FromCallback`:


#### Syntax


```pawn
Indirect_FromCallback(cb, release)
```


#### Parameters


| 	**Name**	 | 	**Info**	 |
|	---	|	---	|
| 	`cb`	 | 	`F@_@ `	 |
| 	`release`	 | 	`bool `	 |

#### Remarks
A generic public wrapper for calling inline functions.


#### Depends on
* [`INDIRECTION_DATA`](#INDIRECTION_DATA)
* [`INDIRECTION_NAUGHT`](#INDIRECTION_NAUGHT)
* [`INDIRECTION_TAG`](#INDIRECTION_TAG)
* [`Indirect_Call__`](#Indirect_Call__)
* [`Indirect_Release_`](#Indirect_Release_)
#### Attributes
* `public`
#### Estimated stack usage
5 cells



### `Indirect_GetMetaBool`:


#### Syntax


```pawn
Indirect_GetMetaBool(index, &ret)
```


#### Parameters


| 	**Name**	 | 	**Info**	 |
|	---	|	---	|
| 	`index`	 | 		 |
| 	`ret`	 | 	`bool & `	 |

#### Tag
`bool:`


#### Remarks
Get boolean metadata.


#### Depends on
* [`INDIRECTION_COUNT`](#INDIRECTION_COUNT)
* [`INDIRECTION_META`](#INDIRECTION_META)
* [`false`](#false)
* [`true`](#true)
#### Estimated stack usage
1 cells



### `Indirect_GetMetaFloat`:


#### Syntax


```pawn
Indirect_GetMetaFloat(index, &ret)
```


#### Parameters


| 	**Name**	 | 	**Info**	 |
|	---	|	---	|
| 	`index`	 | 		 |
| 	`ret`	 | 	`Float & `	 |

#### Tag
`bool:`


#### Remarks
Get float metadata.


#### Depends on
* [`INDIRECTION_COUNT`](#INDIRECTION_COUNT)
* [`INDIRECTION_META`](#INDIRECTION_META)
* [`false`](#false)
* [`true`](#true)
#### Estimated stack usage
1 cells



### `Indirect_GetMetaInt`:


#### Syntax


```pawn
Indirect_GetMetaInt(index, &ret)
```


#### Parameters


| 	**Name**	 | 	**Info**	 |
|	---	|	---	|
| 	`index`	 | 		 |
| 	`ret`	 | 	` & `	 |

#### Tag
`bool:`


#### Remarks
Get integer metadata.


#### Depends on
* [`INDIRECTION_COUNT`](#INDIRECTION_COUNT)
* [`INDIRECTION_META`](#INDIRECTION_META)
* [`false`](#false)
* [`true`](#true)
#### Estimated stack usage
1 cells



### `Indirect_GetMetaRef`:


#### Syntax


```pawn
Indirect_GetMetaRef(index, &ret)
```


#### Parameters


| 	**Name**	 | 	**Info**	 |
|	---	|	---	|
| 	`index`	 | 		 |
| 	`ret`	 | 	` & `	 |

#### Tag
`bool:`


#### Remarks
Get ref metadata.


#### Depends on
* [`INDIRECTION_COUNT`](#INDIRECTION_COUNT)
* [`INDIRECTION_META`](#INDIRECTION_META)
* [`false`](#false)
* [`true`](#true)
#### Estimated stack usage
1 cells



### `Indirect_GetMetaString`:


#### Syntax


```pawn
Indirect_GetMetaString(index, dest[], size)
```


#### Parameters


| 	**Name**	 | 	**Info**	 |
|	---	|	---	|
| 	`index`	 | 		 |
| 	`dest`	 | 	` [] `	 |
| 	`size`	 | 		 |

#### Tag
`bool:`


#### Remarks
Get ref metadata.


#### Depends on
* [`INDIRECTION_COUNT`](#INDIRECTION_COUNT)
* [`INDIRECTION_META`](#INDIRECTION_META)
* [`Indirect_Strcat`](#Indirect_Strcat)
* [`false`](#false)
* [`true`](#true)
#### Estimated stack usage
5 cells



### `Indirect_Init`:


#### Syntax


```pawn
Indirect_Init()
```

#### Remarks
Get the size of the COD AMX segment.


#### Depends on
* [`AMX_HDR`](#AMX_HDR)
* [`AMX_HDR_COD`](#AMX_HDR_COD)
* [`AMX_HDR_DAT`](#AMX_HDR_DAT)
* [`AddressofResolve`](#AddressofResolve)
* [`GetAmxHeader`](#GetAmxHeader)
* [`gsCodSize`](#gsCodSize)
#### Estimated stack usage
21 cells



### `Indirect_Memcpy`:


#### Syntax


```pawn
Indirect_Memcpy(dest[], source, index, numbytes, maxlength)
```


#### Parameters


| 	**Name**	 | 	**Info**	 |
|	---	|	---	|
| 	`dest`	 | 	` [] `	 |
| 	`source`	 | 		 |
| 	`index`	 | 		 |
| 	`numbytes`	 | 		 |
| 	`maxlength`	 | 		 |

#### Attributes
* `native`

### `Indirect_SetMetaRef`:


#### Syntax


```pawn
Indirect_SetMetaRef(index, val)
```


#### Parameters


| 	**Name**	 | 	**Info**	 |
|	---	|	---	|
| 	`index`	 | 		 |
| 	`val`	 | 		 |

#### Tag
`bool:`


#### Remarks
Set ref metadata.


#### Depends on
* [`INDIRECTION_COUNT`](#INDIRECTION_COUNT)
* [`INDIRECTION_META`](#INDIRECTION_META)
* [`false`](#false)
* [`true`](#true)
#### Estimated stack usage
1 cells



### `Indirect_Strcat`:


#### Syntax


```pawn
Indirect_Strcat(dest[], source, maxlength)
```


#### Parameters


| 	**Name**	 | 	**Info**	 |
|	---	|	---	|
| 	`dest`	 | 	` [] `	 |
| 	`source`	 | 		 |
| 	`maxlength`	 | 		 |

#### Attributes
* `native`

### `Indirect_Tag`:


#### Syntax


```pawn
Indirect_Tag(id, dest[])
```


#### Parameters


| 	**Name**	 | 	**Info**	 |
|	---	|	---	|
| 	`id`	 | 	The ID of the tag to get the specifiers from the name of.	 |
| 	`dest`	 | 	` [32] ` Where to store the name.	 |

#### Remarks
Functions are tagged with a special tag containing their specifiers. Get the string value of that tag from the AMX header.


#### Depends on
* [`GetTagNameFromID`](#GetTagNameFromID)
* [`strcat`](#strcat)
#### Estimated stack usage
6 cells



### `OnScriptInit@C`:


#### Syntax


```pawn
OnScriptInit@C()
```

#### Depends on
* [`Indirect_Init`](#Indirect_Init)
#### Attributes
* `public`
#### Estimated stack usage
3 cells



### `OnScriptInit@E`:


#### Syntax


```pawn
OnScriptInit@E()
```

#### Depends on
* [`Indirect_Init`](#Indirect_Init)
#### Attributes
* `public`
#### Estimated stack usage
3 cells



### `ScriptInit_OnJITCompile`:


#### Syntax


```pawn
ScriptInit_OnJITCompile()
```

#### Depends on
* [`Indirect_Init`](#Indirect_Init)
#### Attributes
* `public`
#### Automaton
_ALS


#### Estimated stack usage
3 cells

