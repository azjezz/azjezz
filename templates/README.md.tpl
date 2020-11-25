### Hey 👋

My name is Saif Eddin, I'm a sofware developer, , an open-source enthusiast and contributor.

Curious what I've been working on on recently?

#### 👷 Check out what I'm currently working on
{{range recentContributions 12}}
- [{{.Repo.Name}}]({{.Repo.URL}}) - {{.Repo.Description}} ({{humanize .OccurredAt}})
{{- end}}

#### 🌱 My latest projects
{{range recentRepos 12}}
- [{{.Name}}]({{.URL}}) - {{.Description}}
{{- end}}

#### 🔭 Latest releases I've contributed to
{{range recentReleases 12}}
- [{{.Name}}]({{.URL}}) ([{{.LastRelease.TagName}}]({{.LastRelease.URL}}), {{humanize .LastRelease.PublishedAt}}) - {{.Description}}
{{- end}}

#### 📫 How to reach me

- Twitter: [@azjezz](https://twitter.com/azjezz)
- Keybase: [@azjezz](https://keybase.io/azjezz)
- Email: [azjezz@protonmail.com](mailto://azjezz@protonmail.com)
