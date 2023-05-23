```mermaid
sequenceDiagram
    par 
        UI->>Backend: Request for items
    Backend->>UI: Items returned
    and 
        UI->>Cart Service: Fetch items in cart
        par 
            Cart Service->>Cart Cache: Pull data from Cache
            Cart Cache->>Cart Service: Pull data from Cache
        end
    Cart Service->>UI: Items returned
    end
```
