function update-apms -d "Update, upgrade, dedupe, and clean Atom apms"
  command apm update; and apm upgrade; and apm dedupe; and apm clean
end
