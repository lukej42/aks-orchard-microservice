FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["src/OrchardSite.Web/OrchardSite.Web.csproj", "OrchardSite.Web/"]
COPY ["src/OrchardSite.Themes/OrchardSite.Themes.csproj", "OrchardSite.Themes/"]
RUN dotnet restore "OrchardSite.Web/OrchardSite.Web.csproj"
COPY . .
WORKDIR "/src/OrchardSite.Web"
RUN dotnet publish "OrchardSite.Web.csproj" -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "OrchardSite.Web.dll"]