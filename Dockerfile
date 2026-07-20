FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["src/OrchardSite.Web/OrchardSite.Web.csproj", "OrchardSite.Web/"]
COPY ["src/OrchardSite.Themes/OrchardSite.Themes.csproj", "OrchardSite.Themes/"]
RUN dotnet restore "OrchardSite.Web/OrchardSite.Web.csproj"
COPY . .
WORKDIR "/src/OrchardSite.Web"
RUN dotnet publish "OrchardSite.Web.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
ENV ASPNETCORE_URLS=http://+:8080
ENV ASPNETCORE_ENVIRONMENT=Production
EXPOSE 8080
RUN mkdir -p /app/App_Data && chown -R $APP_UID:$APP_UID /app
COPY --from=build /app/publish .
USER $APP_UID
ENTRYPOINT ["dotnet", "OrchardSite.Web.dll"]
