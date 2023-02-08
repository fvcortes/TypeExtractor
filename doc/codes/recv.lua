-- bad way (extractor)
list:
    { element:integer,
      next:
        { element:integer,
          next:
            { element:integer,
              next:
                { ... }
            }
        }
     }

-- nice way
list: {element:integer, next:list}