# Alejandro Clean Profilarr PCD

A clean personal Profilarr-compliant database for Radarr and Sonarr.

This starter contains **no curated profiles**, **no curated custom formats**, and **no imported third-party rules**. It is only the database shell Profilarr needs so you can create everything yourself from the Profilarr UI.

## Files

```text
pcd.json      # Database manifest
ops/          # Profilarr-created operations live here after export/publish workflows
tweaks/       # Optional local SQL tweaks/variants
```

## How to use

1. Create a new GitHub repository, for example:
   `alejandro-clean-profilarr-pcd`

2. Upload these files to that repository.

3. In Profilarr, go to **Databases** and link your new GitHub repository.

4. After it links successfully, go to:
   - **Custom Formats** → select this DB → **+ New**
   - **Quality Profiles** → select this DB → **+ New**

5. Create your own formats and profiles from scratch.

## Recommended workflow

Use this database as your personal source-of-truth. Do not manually edit the same managed profiles directly in Radarr/Sonarr unless you intentionally want them outside Profilarr management.

## Notes for your setup

For your strict BluRay target style, create profiles inside Profilarr with BluRay cutoffs/targets only after this database is linked. This starter intentionally does not pre-create any profile or custom format so nothing from Dictionarry, TRaSH, or Dumpstarr is mixed in.
